#   Copyright (c) 2010-2011, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

require 'spec_helper'

describe ApplicationController do
  controller do
    def user_signed_in?
      nil
    end

    def current_user
      nil
    end

    def index
      render :nothing => true
    end
  end

  describe '#set_git_headers' do
    context 'with git info' do
      before do
        AppConfig[:git_update] = 'yesterday'
        AppConfig[:git_revision] = '02395'
      end

      it 'sets the git header if there is git info' do
        get :index
        response.headers['X-Git-Update'].should == 'yesterday'
        response.headers['X-Git-Revision'].should == '02395'
      end
    end
    #this context is commented out because the code to do it gets applied at environment load.
    #context 'without git info' do
    #  before do
    #    AppConfig.config_vars.delete(:git_update)
    #    AppConfig.config_vars.delete(:git_revision)
    #  end
    #  it 'does not set the headers if there is no git info' do
    #    get :index
    #    response.headers.keys.should_not include('X-Git-Update')
    #    response.headers.keys.should_not include('X-Git-Revision')
    #  end
    #end
  end

  describe "#set_locale" do
    it 'defaults to the default language' do
      get :index
      I18n.locale.should == DEFAULT_LANGUAGE.to_sym
    end

    it 'prefers a param passed to the page' do
      get :index, :lang => 'es'
      I18n.locale.should == 'es'.to_sym
    end

    it 'defaults to the current users language'

    it 'if no one is signed in, it tries to infer it from the request'

  end
end
