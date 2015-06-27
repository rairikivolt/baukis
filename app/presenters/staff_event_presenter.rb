class StaffEventPresenter < ModelPresenter  #ModelPersenter > ModelPresenter
  delegate :member, :description, :occurred_at, to: :object

  def table_row
    markup(:tr) do |m|
      unless view_context.instance_variable_get(:@staff_member)
        m.td do
          m << link_to(member.family_name + member.given_name,
            [ :admin, member, :staff_events ])
        end
      end
      m.td description
      m.td(:class => 'date') do
        m.text occurred_at.strftime('%Y/%m/%d %H:%M:%S')
      end
    end
  end
end

#used to be staff_events/_event.html.erb
#
#<tr>
#  <% unless @staff_member %>
#  <td>
#    <%= link_to(event.member.family_name + event.member.given_name,
#    [ :admin, event.member, :staff_events ]) %>
#  </td>
#  <% end %>
#  <td><%= event.description %></td>
#  <td class='date'>
#    <%= event.occurred_at.strftime('%Y/%m/%d %H:%M:%S') %>
#  </td>
#</tr>
