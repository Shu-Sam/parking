module Commentable
  extend ActiveSupport::Concern
  include ActionView::RecordIdentifier
  include RecordHelper

  included do
    before_action :authenticate_user!
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.parent_id = @parent&.id

    respond_to do |format|
      if @comment.save
        valid_record_actions(format)
      else
        invalid_record_actions(format)
      end
    end
  end

  private

  def valid_record_actions(format)
    comment = Comment.new
    format.html { redirect_to @commentable }
    format.turbo_stream { parent?(comment) }
  end

  def invalid_record_actions(format)
    format.turbo_stream do
      render turbo_stream: turbo_stream.replace(dom_id_for_records(@parent || @commentable, @comment),
                                                partial: 'comments/form',
                                                locals: { comment: @comment, commentable: @parent || @commentable })
    end
    format.html { redirect_to @commentable }
  end

  def parent?(comment)
    if @parent
      render turbo_stream: turbo_stream.replace(dom_id_for_records(@parent, comment),
                                                partial: 'comments/form',
                                                locals: { comment:, commentable: @parent,
                                                          data: { comment_reply_target: :form }, class: 'd-none' })
    else
      render turbo_stream: turbo_stream.replace(dom_id_for_records(@commentable, comment),
                                                partial: 'comments/form',
                                                locals: { comment:, commentable: @commentable })
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
