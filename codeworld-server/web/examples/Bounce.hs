{----- BEGIN LICENSE TEXT -----
  Copyright 2014 Google Inc. All rights reserved.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
----- END LICENSE TEXT -----}
{-
    Example: Bounce

    In this example, a ball bounces around the screen.  The ball starts with
    a random position and velocity, and bounces when it hits the edge of the
    screen.
-}

main = simulationOf(initial, step, draw)

data World = Ball(Point, Vector)

radius = 2
border = 10 - radius

initial(x:y:vx:vy:_) = Ball((16*x  - 8, 16*y  - 8),
                            (16*vx - 8, 16*vy - 8))

step(world, dt) = bounce(move(world, dt))

move(Ball((x,y), (vx,vy)), dt) = Ball((x + vx*dt, y + vy*dt), (vx, vy))

bounce(Ball((x,y), (vx,vy))) = Ball((nx,ny), (nvx, nvy))
  where nx  = fence(-border, border, x)
        ny  = fence(-border, border, y)
        nvx = if nx /= x then -vx else vx
        nvy = if ny /= y then -vy else vy

fence(lo, hi, x) = max(lo, min(hi, x))

draw(Ball((x,y),_)) = translate(solidCircle(radius), x, y)
