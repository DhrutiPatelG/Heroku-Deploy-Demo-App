# frozen_string_literal: true
SecureHeaders::Configuration.default do |config|
  config.cookies = {
    secure: true, # mark all cookies as "Secure"
    httponly: true, # mark all cookies as "HttpOnly"
    samesite: {
      lax: true # mark all cookies as SameSite=lax
    }
  }
  # Add "; preload" and submit the site to hstspreload.org for best protection.
  config.hsts = "max-age=#{1.week.to_i}"
  config.x_frame_options = "DENY"
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.x_download_options = "noopen"
  config.x_permitted_cross_domain_policies = "none"
  config.referrer_policy = %w(origin-when-cross-origin strict-origin-when-cross-origin)
  config.csp = {
    # "meta" values. these will shape the header, but the values are not included in the header.
    # preserve_schemes: true, # default: false. Schemes are removed from host sources to save bytes and discourage mixed content.
    #disable_nonce_backwards_compatibility: true, # default: false. If false, `unsafe-inline` will be added automatically when using nonces. If true, it won't. See #403 for why you'd want this.

    # directive values: these values will directly translate into source directives
    default_src: %w('self' 'unsafe-inline'),
    font_src: %w('self' data:),
    object_src: %w('self'),
    frame_ancestors: %w('none'),
    form_action: %w('self'),
    media_src: %w('self'),
    connect_src: %w('self' 'unsafe-inline' https://viewapi.larvol.com),
    img_src: %w('self' data:),
    script_src: %w('self' 'unsafe-inline'),
    style_src: %w('self' 'unsafe-inline')
  }
end
