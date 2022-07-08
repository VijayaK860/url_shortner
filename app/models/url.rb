class Url < ApplicationRecord
  validates :url, presence: true

  def self.generate_link(url)
    url = Url.new(url: url)
    return url unless url.valid?

    url.shortcode = SecureRandom.uuid[0..5]
    return url if url.save

    Url.generate_link(url)
  end

  def short
    Rails.application.routes.url_helpers.short_url(slug: self.shortcode)
  end
end
