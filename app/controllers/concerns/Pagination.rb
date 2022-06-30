
module Pagination
    extend ActiveSupport::Concern
  
    def default_per_page
      25
    end
  
    def page_no
      params[:page]&.to_i || 1
    end
  
    def per_page
      params[:per_page]&.to_i || default_per_page
    end
  
    def paginate_offset
      (page_no-1)*per_page
    end
  
    def paginate
      ->(it){ it.limit(per_page).offset(paginate_offset) }
    end
  end