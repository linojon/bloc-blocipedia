module ApplicationHelper

  def flash_class_for
    {
      'success' => 'alert alert-success',
      'notice'  => 'alert alert-success',
      'error'   => 'alert alert-danger',
      'alert'   => 'alert alert-warning'
    }
  end
end
