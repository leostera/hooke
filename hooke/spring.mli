(**
  // For background on the algorithm see:
  // https://www.ryanjuckett.com/damped-springs/

 *****************************************************************************

    Copyright (c) 2008-2012 Ryan Juckett
    http://www.ryanjuckett.com/

    This software is provided 'as-is', without any express or implied
    warranty. In no event will the authors be held liable for any damages
    arising from the use of this software.

    Permission is granted to anyone to use this software for any purpose,
    including commercial applications, and to alter it and redistribute it
    freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented; you must not
       claim that you wrote the original software. If you use this software
       in a product, an acknowledgment in the product documentation would be
       appreciated but is not required.

    2. Altered source versions must be plainly marked as such, and must not be
       misrepresented as being the original software.

    3. This notice may not be removed or altered from any source
       distribution.

  *******************************************************************************

    Ported to Go by Charmbracelet, Inc. in 2021.

  *******************************************************************************

    Source: https://github.com/charmbracelet/harmonica/blob/master/spring.go

    Ported to OCaml by Abstract Machines Sweden AB. in 2023.

  *******************************************************************************
*)

val epsilon : float

type t

val identity : t

val make : delta_time:float -> angular_freq:float -> damping_ratio:float -> t
(** [Spring.make ~delta_time ~angular_freq ~damping_ratio] creates a new
    spring that follows these parameters.

* `delta_time`: the time step to operate on. Game engines typically provide a way to determine the time delta, however if that's not available you can simply set the framerate with `1_000 /. fps`. Make sure the framerate you set here matches your actual framerate.

  * `angular_freq`: this translates roughly to the speed. Higher values are faster.

  * `damping_ratio`: the springiness of the animation, generally between `0` and `1`, though it can go higher. Lower values are springier.

*)

type snapshot = { position : float; velocity : float }
(** A [snapshot] is a utility type representing a spring at a particular point in time. *)

val zero_snapshot : snapshot
val update : t -> snapshot -> target_pos:float -> snapshot
