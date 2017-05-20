module Autocomplete
  class API < Grape::API
    include ActionView::Helpers::TextHelper

    format :json

    get '/autocomplete/model/:model/query' do
      query = params[:query]
      model = params[:model]
      model_class = model.camelize.singularize.constantize
      search = model_class.search do
        fulltext query do
          highlight :description
          #highlight :address
        end
        paginate :page => 1, :per_page => 5
      end

      search_hits_highlights = search.hits.flat_map do |hit|
        hit_highlights = hit.highlights.map do |hit_highlight|
          value = hit_highlight.format { |word| "#{word}" }
          truncated_value = value.truncate(30, separator: ' ', omission: '')

          data = hit.result.id

          {:value => truncated_value, :data => data}
        end

        hit_highlights
      end

      {
        :query => query,
        :suggestions => search_hits_highlights
      }
    end
  end
end
