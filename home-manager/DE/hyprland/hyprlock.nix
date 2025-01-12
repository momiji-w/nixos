{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [{
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
      }];

      input-field = [{
        placeholder_text = "Password...";
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        outline_thickness = 5;
        shadow_passes = 2;
      }];
    };
  };
}
