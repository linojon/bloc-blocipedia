module ApplicationHelper

  def flash_class_for
    {
      notice: 'alert alert-success',
      error:  'alert alert-danger',
      alert:  'alert alert-warning'
    }
  end
end
