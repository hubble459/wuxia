import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/comment.pb.dart';
import 'package:wuxia/partial/logged_in_gate.dart';
import 'package:wuxia/partial/responsive_content.dart';
import 'package:wuxia/screen/social/friends_screen.dart';
import 'package:wuxia/util/app_routes.dart';

String _t(BuildContext context, String key, [Map<String, String>? params]) =>
    FlutterI18n.translate(context, 'comments.$key', translationParams: params);

/// Replies nest visually up to this depth; deeper threads continue on their own screen.
const _maxDepth = 5;
const _pageSize = 20;

/// Every comment on a manga ([mangaId]), or one comment and the replies under it ([commentId]).
class CommentsScreen extends StatelessWidget {
  final int? mangaId;
  final int? commentId;

  const CommentsScreen({super.key, this.mangaId, this.commentId}) : assert(mangaId != null || commentId != null);

  @override
  Widget build(BuildContext context) => LoggedInGate(
        builder: (context) => commentId != null ? _ThreadScreen(commentId: commentId!) : _MangaComments(mangaId: mangaId!),
      );
}

class _MangaComments extends StatefulWidget {
  final int mangaId;

  const _MangaComments({required this.mangaId});

  @override
  State<_MangaComments> createState() => _MangaCommentsState();
}

class _MangaCommentsState extends State<_MangaComments> {
  final List<CommentReply> _comments = [];
  Int64 _nextPage = Int64.ZERO;
  bool _hasMore = true;
  bool _loading = false;
  Object? _error;
  int _total = 0;

  @override
  void initState() {
    super.initState();
    _loadMore();
  }

  Future<void> _reload() async {
    setState(() {
      _comments.clear();
      _nextPage = Int64.ZERO;
      _hasMore = true;
      _error = null;
    });
    await _loadMore();
  }

  Future<void> _loadMore() async {
    if (_loading || !_hasMore) return;
    setState(() => _loading = true);
    try {
      final reply = await api.comment.list(
        ListCommentsRequest(mangaId: widget.mangaId, page: _nextPage, perPage: Int64(_pageSize)),
      );
      if (!mounted) return;
      setState(() {
        _comments.addAll(reply.items);
        _total = reply.totalComments.toInt();
        _hasMore = reply.items.isNotEmpty && reply.pagination.page < reply.pagination.maxPage;
        _nextPage = reply.pagination.page + 1;
      });
    } catch (e) {
      if (mounted) setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _write() async {
    final comment = await showCommentComposer(context, mangaId: widget.mangaId);
    if (comment == null || !mounted) return;
    setState(() {
      _comments.insert(0, comment);
      _total++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_total == 0 ? _t(context, 'title') : _t(context, 'title_count', {'amount': '$_total'}))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _write,
        icon: const Icon(Icons.edit),
        label: Text(_t(context, 'write')),
      ),
      body: ResponsiveContent(
        child: RefreshIndicator(
          onRefresh: _reload,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.extentAfter < 400) _loadMore();
              return false;
            },
            child: _comments.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(48),
                        child: _loading
                            ? const Center(child: CircularProgressIndicator())
                            : Column(
                                children: [
                                  const Text('💬', style: TextStyle(fontSize: 56)),
                                  const SizedBox(height: 12),
                                  Text(
                                    _error != null ? errorMessage(_error!) : _t(context, 'empty'),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                      ),
                    ],
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 96),
                    itemCount: _comments.length + (_hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= _comments.length) {
                        return const Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator()));
                      }
                      final comment = _comments[index];
                      return Column(
                        children: [
                          CommentNode(
                            key: ValueKey(comment.id),
                            comment: comment,
                            depth: 0,
                            onRemoved: () => setState(() {
                              _comments.removeAt(index);
                              _total--;
                            }),
                          ),
                          const Divider(height: 1, color: Colors.white10),
                        ],
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

/// One comment from deep inside a thread, with the comments above it for context.
class _ThreadScreen extends StatefulWidget {
  final int commentId;

  const _ThreadScreen({required this.commentId});

  @override
  State<_ThreadScreen> createState() => _ThreadScreenState();
}

class _ThreadScreenState extends State<_ThreadScreen> {
  late Future<CommentThreadReply> _thread = api.comment.thread(GetCommentRequest(id: widget.commentId));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_t(context, 'thread'))),
      body: ResponsiveContent(
        child: FutureBuilder<CommentThreadReply>(
          future: _thread,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Center(child: Text(errorMessage(snapshot.error!)));
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
            final thread = snapshot.data!;
            final mangaId = thread.comment.mangaId;
            return RefreshIndicator(
              onRefresh: () async {
                final next = api.comment.thread(GetCommentRequest(id: widget.commentId));
                setState(() => _thread = next);
                await next;
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 48),
                children: [
                  ListTile(
                    leading: const Icon(Icons.forum_outlined),
                    title: Text(_t(context, 'all_comments')),
                    onTap: () => Navigator.of(context).pushNamed(commentsRouteName(mangaId)),
                  ),
                  for (final ancestor in thread.ancestors)
                    Opacity(
                      opacity: 0.55,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pushReplacementNamed(commentThreadRouteName(ancestor.id)),
                        child: _CommentBody(comment: ancestor, compact: true),
                      ),
                    ),
                  if (thread.ancestors.isNotEmpty) const Divider(color: Colors.white24),
                  CommentNode(
                    comment: thread.comment,
                    depth: 0,
                    initiallyExpanded: true,
                    onRemoved: () => Navigator.of(context).maybePop(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// A comment with its replies, which load when expanded and nest up to [_maxDepth].
class CommentNode extends StatefulWidget {
  final CommentReply comment;
  final int depth;
  final bool initiallyExpanded;
  final VoidCallback onRemoved;

  const CommentNode({
    super.key,
    required this.comment,
    required this.depth,
    required this.onRemoved,
    this.initiallyExpanded = false,
  });

  @override
  State<CommentNode> createState() => _CommentNodeState();
}

class _CommentNodeState extends State<CommentNode> {
  late CommentReply _comment = widget.comment;
  final List<CommentReply> _replies = [];
  Int64 _nextPage = Int64.ZERO;
  bool _expanded = false;
  bool _loading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    if (widget.initiallyExpanded && _comment.replyCount > 0) _expand();
  }

  int get _replyCount => _comment.replyCount.toInt();

  Future<void> _expand() async {
    setState(() => _expanded = true);
    if (_replies.isEmpty) await _loadMore();
  }

  Future<void> _loadMore() async {
    if (_loading || !_hasMore) return;
    setState(() => _loading = true);
    try {
      final reply = await api.comment.list(
        ListCommentsRequest(
          mangaId: _comment.mangaId,
          parentId: _comment.id,
          page: _nextPage,
          perPage: Int64(_pageSize),
        ),
      );
      if (!mounted) return;
      setState(() {
        final known = _replies.map((r) => r.id).toSet();
        _replies.addAll(reply.items.where((r) => !known.contains(r.id)));
        _hasMore = reply.items.isNotEmpty && reply.pagination.page < reply.pagination.maxPage;
        _nextPage = reply.pagination.page + 1;
      });
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _reply() async {
    final reply = await showCommentComposer(context, mangaId: _comment.mangaId, replyTo: _comment);
    if (reply == null || !mounted) return;
    if (widget.depth + 1 >= _maxDepth) {
      setState(() => _comment = _comment.deepCopy()..replyCount = _comment.replyCount + 1);
      Navigator.of(context).pushNamed(commentThreadRouteName(_comment.id));
      return;
    }
    setState(() {
      _comment = _comment.deepCopy()..replyCount = _comment.replyCount + 1;
      _replies.add(reply);
      _expanded = true;
    });
  }

  Future<void> _edit() async {
    final edited = await showCommentComposer(context, mangaId: _comment.mangaId, editing: _comment);
    if (edited != null && mounted) setState(() => _comment = edited..replyCount = _comment.replyCount);
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_t(context, 'delete_title')),
        content: Text(_t(context, 'delete_body')),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(_t(context, 'cancel'))),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(_t(context, 'delete'), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await api.comment.delete(DeleteCommentRequest(id: _comment.id));
      if (!mounted) return;
      if (_replyCount > 0) {
        setState(() => _comment = _comment.deepCopy()
          ..deleted = true
          ..body = ''
          ..clearUserId()
          ..username = ''
          ..isMine = false
          ..canDelete = false);
      } else {
        widget.onRemoved();
      }
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deepEnd = widget.depth + 1 >= _maxDepth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CommentBody(
          comment: _comment,
          onReply: _comment.deleted ? null : _reply,
          onEdit: _comment.isMine ? _edit : null,
          onDelete: _comment.canDelete ? _delete : null,
        ),
        if (_replyCount > 0)
          Padding(
            padding: const EdgeInsets.only(left: 56, bottom: 4),
            child: deepEnd
                ? TextButton.icon(
                    onPressed: () => Navigator.of(context).pushNamed(commentThreadRouteName(_comment.id)),
                    icon: const Icon(Icons.subdirectory_arrow_right, size: 18),
                    label: Text(_t(context, 'continue_thread', {'amount': '$_replyCount'})),
                  )
                : !_expanded
                    ? TextButton.icon(
                        onPressed: _expand,
                        icon: const Icon(Icons.expand_more, size: 18),
                        label: Text(_t(context, _replyCount == 1 ? 'view_reply' : 'view_replies', {'amount': '$_replyCount'})),
                      )
                    : null,
          ),
        if (_expanded && !deepEnd)
          Container(
            margin: const EdgeInsets.only(left: 30),
            padding: const EdgeInsets.only(left: 6),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.35), width: 2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final (i, reply) in _replies.indexed)
                  CommentNode(
                    key: ValueKey(reply.id),
                    comment: reply,
                    depth: widget.depth + 1,
                    onRemoved: () => setState(() {
                      _replies.removeAt(i);
                      _comment = _comment.deepCopy()..replyCount = _comment.replyCount - 1;
                    }),
                  ),
                if (_loading)
                  const Padding(padding: EdgeInsets.all(8), child: SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)))
                else if (_hasMore && _replies.length < _replyCount)
                  TextButton(
                    onPressed: _loadMore,
                    child: Text(_t(context, 'more_replies', {'amount': '${_replyCount - _replies.length}'})),
                  ),
                TextButton.icon(
                  onPressed: () => setState(() => _expanded = false),
                  icon: const Icon(Icons.expand_less, size: 18),
                  label: Text(_t(context, 'hide_replies')),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _CommentBody extends StatelessWidget {
  final CommentReply comment;
  final bool compact;
  final VoidCallback? onReply;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const _CommentBody({required this.comment, this.compact = false, this.onReply, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final when = Jiffy.parseFromMillisecondsSinceEpoch(comment.createdAt.toInt()).fromNow();

    return Padding(
      padding: EdgeInsets.fromLTRB(12, compact ? 6 : 10, 4, compact ? 6 : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          comment.deleted
              ? const CircleAvatar(radius: 16, backgroundColor: Colors.white10, child: Icon(Icons.delete_outline, size: 16))
              : GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(profileRouteName(comment.username)),
                  child: UserAvatar(username: comment.username, radius: 16),
                ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: comment.deleted
                            ? null
                            : () => Navigator.of(context).pushNamed(profileRouteName(comment.username)),
                        child: Text(
                          comment.deleted ? _t(context, 'deleted_author') : comment.username,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: comment.isMine ? theme.colorScheme.primary : null,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      ' · $when${comment.hasEditedAt() ? ' · ${_t(context, 'edited')}' : ''}',
                      style: theme.textTheme.labelSmall?.copyWith(color: Colors.white54),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  comment.deleted ? _t(context, 'deleted') : comment.body,
                  maxLines: compact ? 2 : null,
                  overflow: compact ? TextOverflow.ellipsis : null,
                  style: comment.deleted
                      ? theme.textTheme.bodyMedium?.copyWith(color: Colors.white38, fontStyle: FontStyle.italic)
                      : theme.textTheme.bodyMedium,
                ),
                if (!compact)
                  Row(
                    children: [
                      if (onReply != null)
                        TextButton.icon(
                          style: TextButton.styleFrom(visualDensity: VisualDensity.compact, padding: EdgeInsets.zero),
                          onPressed: onReply,
                          icon: const Icon(Icons.reply, size: 16),
                          label: Text(_t(context, 'reply')),
                        ),
                      const Spacer(),
                      if (onEdit != null || onDelete != null)
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_horiz, size: 18),
                          onSelected: (action) => action == 'edit' ? onEdit?.call() : onDelete?.call(),
                          itemBuilder: (context) => [
                            if (onEdit != null) PopupMenuItem(value: 'edit', child: Text(_t(context, 'edit'))),
                            if (onDelete != null)
                              PopupMenuItem(
                                value: 'delete',
                                child: Text(_t(context, 'delete'), style: const TextStyle(color: Colors.red)),
                              ),
                          ],
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Writes a new comment, a reply to [replyTo], or an edit of [editing]; returns the saved comment.
Future<CommentReply?> showCommentComposer(
  BuildContext context, {
  required int mangaId,
  CommentReply? replyTo,
  CommentReply? editing,
}) {
  return showModalBottomSheet<CommentReply>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _Composer(mangaId: mangaId, replyTo: replyTo, editing: editing),
  );
}

class _Composer extends StatefulWidget {
  final int mangaId;
  final CommentReply? replyTo;
  final CommentReply? editing;

  const _Composer({required this.mangaId, this.replyTo, this.editing});

  @override
  State<_Composer> createState() => _ComposerState();
}

class _ComposerState extends State<_Composer> {
  late final _text = TextEditingController(text: widget.editing?.body ?? '');
  bool _sending = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final body = _text.text.trim();
    if (body.isEmpty || _sending) return;
    setState(() => _sending = true);
    try {
      final saved = widget.editing != null
          ? await api.comment.edit(EditCommentRequest(id: widget.editing!.id, body: body))
          : await api.comment.create(
              CreateCommentRequest(mangaId: widget.mangaId, parentId: widget.replyTo?.id, body: body),
            );
      if (mounted) Navigator.of(context).pop(saved);
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(context, e);
        setState(() => _sending = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = widget.editing != null
        ? _t(context, 'edit')
        : widget.replyTo != null
            ? _t(context, 'replying_to', {'username': widget.replyTo!.username})
            : _t(context, 'write');

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            if (widget.replyTo != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  widget.replyTo!.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.white54),
                ),
              ),
            const SizedBox(height: 12),
            TextField(
              controller: _text,
              autofocus: true,
              minLines: 3,
              maxLines: 8,
              maxLength: 5000,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(hintText: _t(context, 'hint')),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: _sending ? null : _send,
                icon: _sending
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.send, size: 18),
                label: Text(_t(context, widget.editing != null ? 'save' : 'post')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The newest comments on a manga and a way into the rest, for its detail page.
class CommentsPreview extends StatefulWidget {
  final int mangaId;

  const CommentsPreview({super.key, required this.mangaId});

  @override
  State<CommentsPreview> createState() => _CommentsPreviewState();
}

class _CommentsPreviewState extends State<CommentsPreview> {
  late Future<CommentsReply> _comments = _load();

  Future<CommentsReply> _load() =>
      api.comment.list(ListCommentsRequest(mangaId: widget.mangaId, perPage: Int64(2)));

  Future<void> _open() async {
    await Navigator.of(context).pushNamed(commentsRouteName(widget.mangaId));
    if (mounted) setState(() => _comments = _load());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _open,
        child: FutureBuilder<CommentsReply>(
          future: _comments,
          builder: (context, snapshot) {
            final reply = snapshot.data;
            final total = reply?.totalComments.toInt() ?? 0;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(Icons.forum_outlined),
                    title: Text(
                      total == 0 ? _t(context, 'title') : _t(context, 'title_count', {'amount': '$total'}),
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  if (reply != null && reply.items.isEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Text(_t(context, 'be_first'), style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60)),
                    ),
                  for (final comment in reply?.items ?? const <CommentReply>[])
                    IgnorePointer(child: _CommentBody(comment: comment, compact: true)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
