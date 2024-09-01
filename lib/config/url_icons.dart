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
    "https://x.com": "assets/contact_icons/x.svg",
    "tiktok": "assets/contact_icons/tiktok.svg",
    "discord": "assets/contact_icons/discord.svg",
  };
  static const iconsOrder = {
    "maps": 1,
    "tel": 2,
    "mailto:": 3,
    "facebook": 5,
    "instagram": 6,
    "discord": 7,
    "linkedin": 8,
    "github": 9,
    "https://x.com": 10,
    "youtu": 11,
    "tiktok": 12,
  };
  static const defaultIconOrder = 4;
  static const defaultIcon = "assets/contact_icons/web.svg";
}
