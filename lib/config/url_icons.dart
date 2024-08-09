abstract class ContactIconsConfig {
  static const mailLink = "assets/contact_icons/mail.svg";
  static const iconsPaths = {
    "facebook": "assets/contact_icons/fb.svg",
    "instagram": "assets/contact_icons/ig.svg",
    "linkedin": "assets/contact_icons/linkedin.svg",
    "mailto:": mailLink,
    "youtu": "assets/contact_icons/yt.svg",
    "github": "assets/contact_icons/github.svg",
    "maps": "assets/contact_icons/compass.svg",
    "tel": "assets/contact_icons/phone.svg",
  };
  static const iconsOrder = {
    "maps": 1,
    "tel": 2,
    "mailto:": 3,
    "facebook": 5,
    "instagram": 6,
    "linkedin": 7,
    "github": 8,
    "youtu": 9,
  };
  static const defaultIconOrder = 4;
  static const defaultIcon = "assets/contact_icons/web.svg";
}
