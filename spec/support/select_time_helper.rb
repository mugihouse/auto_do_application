module SelectTimeHelpers
  def select_time(hour, minute, options = {})
    field = options[:from]
    base_id = find(:xpath, ".//label[contains(.,'#{field}')]")[:for]
    select hour, from: "#{base_id}_4i"
    select minute, from: "#{base_id}_5i"
  end
end
