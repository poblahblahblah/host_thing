class CommentsController < ApplicationController

  def create
    @node = Node.find(params[:node_id])
    @comment = @node.comments.create(comment_params)
    redirect_to node_path(@node)
  end
 
  def destroy
    @node = Node.find(params[:node_id])
    @comment = @node.comments.find(params[:id])
    @comment.destroy
    redirect_to node_path(@node)
  end
 
  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

end
