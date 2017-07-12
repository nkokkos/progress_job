module ProgressJob
  class ProgressController < ActionController::Base
    
    #include devise method. Devise gem must be included for this to work
    before_action :authenticate_user!  

    def show
      @delayed_job = Delayed::Job.find(params[:job_id])
      percentage = !@delayed_job.progress_max.zero? ? @delayed_job.progress_current / @delayed_job.progress_max.to_f * 100 : 0
      render json: @delayed_job.attributes.merge!(percentage: percentage).to_json
    end

  end
end
