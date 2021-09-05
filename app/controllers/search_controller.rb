class SearchController < ApplicationController
  def search
    q = params[:q]
    @categories = Category.search(name_cont: q).result.order("created_at DESC").paginate(page: params[:pag_categories], per_page: 5)
    @users = User.search(username_cont: q).result.order("created_at DESC").paginate(page: params[:pag_users], per_page: 5)
    @articles = Article.search(title_or_description_cont: q).result.order("created_at DESC").paginate(page: params[:pag_articles], per_page: 5)
  end
end