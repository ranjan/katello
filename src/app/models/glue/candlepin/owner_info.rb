#
# Copyright 2011 Red Hat, Inc.
#
# This software is licensed to you under the GNU General Public
# License as published by the Free Software Foundation; either version
# 2 of the License (GPLv2) or (at your option) any later version.
# There is NO WARRANTY for this software, express or implied,
# including the implied warranties of MERCHANTABILITY,
# NON-INFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. You should
# have received a copy of GPLv2 along with this software; if not, see
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.

require 'resources/candlepin'

class Glue::Candlepin::OwnerInfo



  def initialize(organization)
      @info = Candlepin::OwnerInfo.find(organization.cp_key)
  end


  def total_consumers
    @info['consumerCounts']['system']
  end

  def total_invalid_compliance_consumers
    i = @info['consumerCountsByComplianceStatus']['invalid'] ||= 0
    f = @info['consumerCountsByComplianceStatus']['false'] ||= 0
    return i + f
  end

  def total_valid_compliance_consumers
    v = @info['consumerCountsByComplianceStatus']['valid'] ||= 0
    t = @info['consumerCountsByComplianceStatus']['true'] ||= 0
    return v + t
  end

  def total_partial_compliance_consumers
    @info['consumerCountsByComplianceStatus']['partial'] ||= 0
  end

  private

  def find_value set_key, value_type, entry_type
    @info[set_key].each{|hash|
      if hash['valueType'] == value_type && hash['entryType'] == entry_type
        return hash['value']
      end
    }
    nil
  end



end
