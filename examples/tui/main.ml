[@@@warning "-69"]

open Minttea
open Hooke

type model = { spring : Spring.t; snapshot : Spring.snapshot }

let init _ = Command.Noop

let initial_model () =
  {
    spring = Spring.make ~delta_time:0.02 ~angular_freq:7. ~damping_ratio:0.30;
    snapshot = Spring.zero_snapshot;
  }

let update event model =
  match event with
  | Event.KeyDown "q" -> (model, Command.Quit)
  | Event.Frame ->
      let equilibrium_pos = 30. in
      let snapshot =
        Spring.update model.spring model.snapshot ~equilibrium_pos
      in
      ({ model with snapshot }, Command.Noop)
  | _ -> (model, Command.Noop)

let view model =
  let x = Float.to_int (Float.ceil model.snapshot.position) in
  if x < 0 then ""
  else
    let padding = String.make x ' ' in
    let ball = padding ^ "⚽" in
    Format.asprintf "\n\n%s\n\n\nPress any key to quit" ball

let app = Minttea.app ~initial_model ~init ~update ~view ()
let () = Minttea.start app
