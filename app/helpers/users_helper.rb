module UsersHelper
  def avatar_for(email, size_class: "size-4")
    tag.span class: "inline-flex #{size_class} items-center justify-center rounded-full bg-blue-500" do
      tag.span email[0].upcase, class: "text-sm leading-none text-white"
    end
  end
end
