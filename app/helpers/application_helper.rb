module ApplicationHelper
  def mapping
    {
      error: :danger,
      notice: :info,
      success: :success
    }.with_indifferent_access
  end
end
