class Types::Enums::PostVisibility < Types::Base::Enum
  ::Post::Visibilities::ALL.each { |visibility| value visibility }
end
