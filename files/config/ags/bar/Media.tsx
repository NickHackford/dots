import { bind } from "astal";
import { Gtk } from "astal/gtk3";

import Mpris from "gi://AstalMpris";

export function Media() {
  const mpris = Mpris.get_default();

  return (
    <box vertical={true}>
      {bind(mpris, "players").as((ps) =>
        ps[0] ? (
          <box className="media">
            <box
              className="cover"
              valign={Gtk.Align.CENTER}
              css={bind(ps[0], "coverArt").as(
                (cover) => `background-image: url('${cover}');`,
              )}
            />
            <label
              wrap={true}
              label={bind(ps[0], "title").as(
                () => `${ps[0].title} - ${ps[0].artist}`,
              )}
            />
          </box>
        ) : (
          "Nothing Playing"
        ),
      )}
    </box>
  );
}
