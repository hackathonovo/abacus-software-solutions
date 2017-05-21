module ApplicationHelper
	def hgss_data_header(model_name)
		render partial: "application/hgss/data/header", locals: {title: model_name.to_s.humanize.capitalize, singular_model_name: model_name.to_s.singularize}
	end

	def hgss_data_row_actions(record)
		render partial: "application/hgss/data/row_actions", locals: {record: record}
	end

	def hgss_user(user)
		render partial: "application/hgss/users/user", locals: {user: user}
	end

	def hgss_data_table(columns, rows, &block)
		thead = content_tag :thead do
			content_tag :tr do

				(columns + [:""]).collect do |column|  
					column_name = column.to_s.humanize
					column_name = I18n.t(column_name) if not column_name.blank?
					concat content_tag(:th, column_name)
				end.join().html_safe
			end
 		end

		tbody = content_tag :tbody do
			rows.collect do |row|
				content_tag :tr do
					collected_columns = columns.collect do |column| 
						td_content = capture do
							block.call(column, row)
						end

						content_tag(:td, td_content)
					end.join().html_safe

					row_actions = content_tag(:td, hgss_data_row_actions(row), :width => "207px")

					concat collected_columns.concat(row_actions.html_safe)
				end
			end.join().html_safe
 		end

 		pagination_control = content_tag :div, paginate(rows), class: "flx-right"

 		search = content_tag :div, render(partial:"application/hgss/data/search"), class: "flx-left" 		
 		pagination_control_row = content_tag :div, search.concat(pagination_control), class: "hgss-data-footer"

 		table = content_tag :table, thead.concat(tbody), class: "table"
 		pagination_control_row.concat(table)
	end
end
