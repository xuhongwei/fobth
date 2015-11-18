RailsAdmin.config do |config|

  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method &:current_admin

  config.included_models = ["Product", "Category","Link","Hot","News", "Contact","Home"]

  config.model Home do
    field :slide_title, :string
    field :slide_url, :string
    field :image, :paperclip

    field :photo_url, :string
    field :photo, :paperclip

    field :image do
      thumb_method :thumb
      delete_method :delete_image
      help 'image size : 580X320'
    end

    field :photo do
      thumb_method :thumb
      delete_method :delete_image
      help 'image size : 280X320'
    end
  end

  config.model Contact do
    field :title, :string
    field :description, :text
    
    create do
      field :description, :ck_editor
    end

    edit do
      field :description, :ck_editor
    end
  end

  config.model News do
    
    field :title, :string
    field :image, :paperclip
    field :content, :text
    field :news_date, :string

    create do
      field :image do
        thumb_method :thumb
        delete_method :delete_image 
        help 'image size : 600X150'
      end
      field :content, :ck_editor
    end

    edit do
      field :image do
        thumb_method :thumb
        delete_method :delete_image 
        help 'image size : 600X150'
      end
      field :content, :ck_editor
    end
  end

  config.model Product do

    field :name, :string
    field :image,:paperclip
    field :category,:belongs_to_association
    field :sequence, :integer
    field :description,:text
    # field :created_at,:datetime
    # field :updated_at,:datetime
    list do
      # field :description,:text do
      #   formatted_value do # used in form views
      #     value.html_safe if value
      #   end
      # end
      field :created_at,:datetime do
        strftime_format "%Y-%m-%d %H:%M:%S"
      end
      field :updated_at,:datetime do
        strftime_format "%Y-%m-%d %H:%M:%S"
      end
    end

    create do
      field :name, :string do

      end
      field :category,:belongs_to_association do

      end
      field :sequence, :integer do

      end
      field :image do
        thumb_method :thumb
        delete_method :delete_image
        help 'image size : 280X150'
      end
      field :description, :ck_editor
    end

    show do
      field :description,:text do
        formatted_value do # used in form views
          value.html_safe if value
        end
      end
      field :created_at,:datetime do
        strftime_format "%Y-%m-%d %H:%M:%S"
      end
      field :updated_at,:datetime do
        strftime_format "%Y-%m-%d %H:%M:%S"
      end
    end
    edit do
      field :name, :string do

      end
      field :category,:belongs_to_association do

      end
      field :sequence, :integer do

      end
      field :image do
        thumb_method :thumb
        delete_method :delete_image 
        help 'image size : 280X150'
      end
      field :description, :ck_editor
    end
  end

  config.model Category do

    field :name, :string
    field :sequence, :integer
    # field :created_at,:datetime
    # field :updated_at,:datetime
    list do
      # field :description,:text do
      #   formatted_value do # used in form views
      #     value.html_safe if value
      #   end
      # end
      field :created_at,:datetime do
        strftime_format "%Y-%m-%d %H:%M:%S"
      end
      field :updated_at,:datetime do
        strftime_format "%Y-%m-%d %H:%M:%S"
      end
    end

    create do
      field :name, :string do

      end
      field :sequence, :integer do

      end
    end

    show do
      field :name, :string do

      end
      field :created_at,:datetime do
        strftime_format "%Y-%m-%d %H:%M:%S"
      end
      field :updated_at,:datetime do
        strftime_format "%Y-%m-%d %H:%M:%S"
      end
    end
    edit do
      field :name, :string do

      end
      field :sequence, :integer do

      end
    end
  end
end
