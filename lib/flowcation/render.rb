module Flowcation
  module Render
    def self.sanitize(s)
      s.
      gsub("%&gt;", "%>").
      gsub("&lt;%", "<%").
      gsub("\r\n", "\n").
      gsub("%20", " ").
      gsub("&amp;", "&")
    end
  end
end