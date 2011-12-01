# Redmine - project management software
# Copyright (C) 2006-2011  See readme for details and license
#

require File.dirname(__FILE__) + '/../../../test_helper'

class Redmine::AccessControlTest < ActiveSupport::TestCase
  
  def setup
    @access_module = Redmine::AccessControl
  end
  
  def test_permissions
    perms = @access_module.permissions
    assert perms.is_a?(Array)
    assert perms.first.is_a?(Redmine::AccessControl::Permission)
  end
  
  def test_module_permission
    perm = @access_module.permission(:view_issues)
    assert perm.is_a?(Redmine::AccessControl::Permission)
    assert_equal :view_issues, perm.name
    assert_equal :issue_tracking, perm.project_module
    assert perm.actions.is_a?(Array)
    assert perm.actions.include?('issues/index')
  end
  
  def test_no_module_permission
    perm = @access_module.permission(:edit_project)
    assert perm.is_a?(Redmine::AccessControl::Permission)
    assert_equal :edit_project, perm.name
    assert_nil perm.project_module
    assert perm.actions.is_a?(Array)
    assert perm.actions.include?('projects/settings')
  end
end
