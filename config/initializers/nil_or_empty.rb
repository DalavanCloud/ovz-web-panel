class Object
  # can't use 'blank?' method b/c on non-utf8 strings
  # it throws 'ArgumentError: invalid byte sequence in UTF-8'
  def nil_or_empty?
    self.nil? || self.try(:empty?)
  end
end
