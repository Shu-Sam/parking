class UserDecorator < ApplicationDecorator
  delegate_all

  def name_with_role
    "#{name}_#{role}".upcase
  end

  def gravatar(size: 40, css_class: '')
    email_hash = Digest::MD5.hexdigest email.strip.downcase

    h.image_tag "https://www.gravatar.com/avatar/#{email_hash}.jpg?s=#{size}",
                class: "rounded #{css_class}"
  end
end
