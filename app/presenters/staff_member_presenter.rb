class StaffMemberPresenter < ModelPresenter
  delegate :suspended?, to: :object

  #職員の停止フラグのon/offを表現する記号を返す。
  # ON  = BALLOT BOX WITH CHECK (U+2611)
  # OFF = BALLOT BOX (U+2610)
  def suspended_mark
    suspended? ? raw('&#x2611;') : raw('&#x2610;')
  end

  def full_name
    object.family_name + " " + object.given_name
  end

  def full_name_kana
    object.family_name_kana + " " + object.given_name_kana
  end
end
