module Graphics.SignaturePad.Types where

import CSS.Color (Color, black, rgba)

data SignaturePad

type Config =
  { dotSize :: Number
  , minWidth :: Number
  , maxWidth :: Number
  , backgroundColor :: Color
  , penColor :: Color
  , velocityFilterWeight :: Number
  , width :: Number
  , height :: Number
  }

defaultConfig :: Config
defaultConfig =
  { dotSize: 1.0
  , minWidth: 0.5
  , maxWidth: 2.5
  , backgroundColor: rgba 0 0 0 0.0
  , penColor: black
  , velocityFilterWeight: 0.7
  , width: 300.0
  , height: 150.0
  }
