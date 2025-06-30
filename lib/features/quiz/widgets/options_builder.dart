class OptionsBuilder {
  // Helper method to create radio button HTML
  static String createRadioButtonHTML(String optionLetter, bool isSelected) {
    String radioColor = isSelected ? "#2196F3" : "#E0E0E0";
    String innerCircle = isSelected
        ? '<div style="width: 8px; height: 8px; background-color: #2196F3; border-radius: 50%; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);"></div>'
        : '';

    return '''
    <div style="display: flex; align-items: center; justify-content: space-between; width: 100%;">
      <div style="display: flex; align-items: center;">
        <span style="
          display: flex; 
          align-items: center; 
          justify-content: center; 
          width: 35px; 
          height: 35px; 
          background-color: $radioColor; 
          border-radius: 50%; 
          margin-left: -30px;
          margin-right: 12px; 
          font-weight: bold; 
          color: white; 
          font-size: 14px;
        ">$optionLetter</span>
        <div style="flex: 1;">
    ''';
  }

  // Helper method to create end selector
  static String closeRadioButtonHTML(bool isSelected) {
    String radioColor = isSelected ? "#2196F3" : "#CCCCCC";
    String innerDot = isSelected
        ? '<div style="width: 8px; height: 8px; background-color: #2196F3; border-radius: 50%;"></div>'
        : '';

    return '''
        </div>
      </div>
      <div style="
        width: 20px; 
        height: 20px; 
        border: 2px solid $radioColor; 
        border-radius: 50%; 
        display: flex; 
        align-items: center; 
        justify-content: center;
      ">
        $innerDot
      </div>
    </div>
    ''';
  }

  static String closeCheckboxHTML(bool isSelected) {
    String checkboxColor = isSelected ? "#2196F3" : "#CCCCCC";
    String checkmark = isSelected
        ? '<span style="color: white; font-size: 14px; font-weight: bold;">✓</span>'
        : '';

    return '''
        </div>
      </div>
      <div style="
        width: 20px; 
        height: 20px; 
        border: 2px solid $checkboxColor; 
        border-radius: 4px; 
        display: flex; 
        align-items: center; 
        justify-content: center; 
        background-color: ${isSelected ? checkboxColor : 'transparent'};
      ">
        $checkmark
      </div>
    </div>
  ''';
  }
}
