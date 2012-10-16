module AttributeReader

  def attributes(*attribute_names)
    attribute_names.each do |name|
      define_method(name) do
        to_hash[name.to_s]
      end
    end
  end

end