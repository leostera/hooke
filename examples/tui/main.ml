[@@@warning "-69"]

open Minttea
open Hooke

type model = { spring : Spring.t; snapshot : Spring.snapshot; running : bool }

let init _ = Command.Set_timer (Riot.Ref.make (), 1.0)

let initial_model () =
  {
    spring =
      Spring.make ~delta_time:(30. /. 1_000.) ~angular_freq:7.
        ~damping_ratio:0.15;
    snapshot = Spring.zero_snapshot;
    running = false;
  }

let update event model =
  match event with
  | Event.KeyDown "q" -> (model, Command.Quit)
  | Event.Timer _ -> ({ model with running = true }, Command.Noop)
  | Event.Frame when model.running ->
      let target_pos = 30. in
      let snapshot = Spring.update model.spring model.snapshot ~target_pos in
      ({ model with snapshot }, Command.Noop)
  | _ -> (model, Command.Noop)

let view model =
  let x = Float.to_int (Float.round model.snapshot.position) in
  if x < 0 then ""
  else
    let padding = String.make x ' ' in
    let ball = padding ^ "⚽" in
    Format.asprintf "\n\n%s\n\n\nPress any key to quit" ball

let app = Minttea.app ~initial_model ~init ~update ~view ()
let () = Minttea.start app
