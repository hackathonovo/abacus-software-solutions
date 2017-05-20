module Autocomplete
  class API < Grape::API
    include ActionView::Helpers::TextHelper

    format :json

    get '/autocomplete/model/rescuers/query' do
      rescuers = Rescuer.search do
        keywords params[:q]
        paginate :page => 1, :per_page => 15
      end

      results = rescuers.results.map do |r|
        {:id => r.id, :text => r.name}
      end

      {:results => results}
    end

    get '/autocomplete/model/:model/query' do
      query = params[:query]
      query = params[:q] if query.nil?

      model = params[:model]
      model_class = model.camelize.singularize.constantize

      search = nil
      if model == "rescuers"
        search = model_class.solr_search do
          fulltext query do
          end
          paginate :page => 1, :per_page => 5
        end
      else
        search = model_class.solr_search do
          fulltext query do
            highlight :description
            #highlight :address
          end
          paginate :page => 1, :per_page => 5
        end
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
