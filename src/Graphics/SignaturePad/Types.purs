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
  }

defaultConfig :: Config
defaultConfig =
  { dotSize: 1.0
  , minWidth: 0.5
  , maxWidth: 2.5
  , backgroundColor: rgba 0 0 0 0.0
  , penColor: black
  , velocityFilterWeight: 0.7
  }
