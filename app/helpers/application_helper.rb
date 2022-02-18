module ApplicationHelper
  def bootstrap_class_for(key)
    {
      success: 'alert-success',
      error: 'alert-danger',
      danger: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }[key.to_sym] || key
  end
end
