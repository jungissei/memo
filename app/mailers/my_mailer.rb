# class MyMailer < ApplicationMailer

#   # Subject can be set in your I18n file at config/locales/en.yml
#   # with the following lookup:
#   #
#   #   en.my_mailer.sendmail_confirm.subject
#   #
#   def sendmail_confirm
#     @greeting = "Hi"

#     mail to: "to@example.org"
#   end
# end

class MyMailer < Devise::Mailer
  def reset_password_instructions(record, token, opts={})
    super(record, token, opts.merge(default_opts))
  end

  def reset_password_instructions(record, token, opts={})
    super(record, token, opts.merge(default_opts))
  end

  def unlock_instructions(record, token, opts={})
    super(record, token, opts.merge(default_opts))
  end

  def default_opts
    {
        bcc: Settings.mail[:bcc]
    }
  end
end