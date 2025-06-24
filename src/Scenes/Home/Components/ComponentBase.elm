module Scenes.Home.Components.ComponentBase exposing (ComponentMsg(..), ComponentTarget, BaseData)

{-|


# Component base

@docs ComponentMsg, ComponentTarget, BaseData

-}

import Color exposing (Color)


{-| Component message
-}
type ComponentMsg
    = NullComponentMsg
    | Comp1InitMsg { order : Int, id : Int, color : Color }
    | PromptBoxOrderForWard


{-| Component target
-}
type alias ComponentTarget =
    String


{-| Component base data
-}
type alias BaseData =
    { order : Int, id : Int, color : Color }
