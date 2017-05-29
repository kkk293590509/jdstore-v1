class WelcomeController < ApplicationController
  layout 'landingpage'
  
  def index
    flash[:notice] = "担心遭遇WannaCry？立即拨打400电话联系我们提供免费上门检测服务"
  end
end
