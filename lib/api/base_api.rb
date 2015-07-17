require 'active_support/all'
require "net/http"
require "uri"
require_relative "helpers/api_helpers.rb"

class BaseApi
  include ApiHelpers

  def initialize(options = {})
    @user_code  = options[:user_code]
    @auth_token = options[:auth_token]
    @logger     = options[:logger]
    @error      = nil
  end

  def configure(options = {})
    @user_code  = options[:user_code] if options[:user_code].present?
    @auth_token = options[:auth_token] if options[:auth_token].present?
    @logger     = options[:logger] if options[:logger]
  end

  def has_error?
    @error.present?
  end

  def get_error
    tmp_error = @error
    @error = nil
    tmp_error
  end

  def error
    @error
  end

  private

  def verify_token
    if @auth_token.present?
      true
    else
      log_or_print "Please set the auth token before continuing"
      false
    end
  end

  def verify_user_code
    if @user_code.present?
      true
    else
      log_or_print "Please set the user code before continuing"
      false
    end
  end

  def verify_env_vars
    vars_present = true
    if ENV['BUFFER_KEY'].blank?
      log_or_print "Please define the 'BUFFER_KEY' variable in the environment before continuing"
      vars_present = false
    end

    if ENV['BUFFER_SECRET'].blank?
      log_or_print "Please define the 'BUFFER_SECRET' variable in the environment before continuing"
      vars_present = false
    end

    vars_present
  end
end
