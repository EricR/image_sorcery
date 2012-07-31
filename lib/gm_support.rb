module GmSupport
  def prefix command
    "gm #{command}"
  end
end

class Sorcery
  class << self
    def gm file
      instance = new(file)
      instance.extend GmSupport
      instance
    end
  end
end
