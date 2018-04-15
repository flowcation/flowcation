module Flowcation
  module Render
    def self.sanitize(s)
      s.
      gsub("%&gt;", "%>").
      gsub("&lt;%", "<%").
      gsub("\r\n", "\n").
      gsub("%20", " ").
      gsub("&amp;", "&").
      gsub("=&gt;", "=>").
      gsub("-&gt;", "->").
      gsub("&gt;", ">").
      gsub("&lt;", "<")
    end
  end
end