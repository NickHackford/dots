import { App, Gdk, Gtk } from "astal/gtk3";
import style from "./style.scss";
import { execAsync } from "astal";

import { Bar } from "./bar/Bar";
import { SystemPopup } from "./bar/System";

import { AppLauncher } from "./widget/AppLauncher";
import { NotificationPopups } from "./widget/NotificationPopups";
import { OSD } from "./widget/OSD";

App.start({
  css: style,
  main() {
    let monitors: Gdk.Monitor[] = App.get_monitors();

    monitors.map(SystemPopup);
    monitors.map(NotificationPopups);
    monitors.map(AppLauncher);
    monitors.map(OSD);
    let bars = new Map<Gdk.Monitor, Gtk.Widget>();

    App.get_monitors().forEach((gdkmonitor) => {
      bars.set(gdkmonitor, Bar(gdkmonitor));
    });

    App.connect("monitor-added", (__, gdkmonitor: Gdk.Monitor) => {
      execAsync([
        "hyprctl",
        "notify",
        "-1",
        "10000",
        "rgb(ff1ea3)",
        `${gdkmonitor.model}`,
      ]);
      bars.set(gdkmonitor, Bar(gdkmonitor));
    });

    App.connect("monitor-removed", (_, gdkmonitor) => {
      execAsync([
        "hyprctl",
        "notify",
        "-1",
        "10000",
        "rgb(ff1ea3)",
        `${gdkmonitor.model}`,
      ]);
      bars.get(gdkmonitor)?.destroy();
      bars.delete(gdkmonitor);
    });
  },
});
