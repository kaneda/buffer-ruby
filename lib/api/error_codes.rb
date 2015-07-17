module ErrorCodes
  ###############
  # ERROR CODES #
  ###############

  CODE_MAP = {
    "401" => {
      "401"  => "Unauthorized."
    },
    "403" => {
      "403"  => "Permission denied.",
      "1001" => "Access token required.",
      "1002" => "Not within application scope.",
      "1011" => "No authorization to access profile.",
      "1013" => "Profile schedule limit reached.",
      "1014" => "Profile limit for user has been reached.",
      "1015" => "Profile could not be destroyed.",
      "1021" => "No authorization to access update.",
      "1023" => "Update limit for profile has been reached.",
      "1024" => "Update limit for team profile has been reached.",
      "1028" => "Update soft limit for profile reached.",
      "1051" => "No authorization to access client."
    },
    "404" => {
      "404"  => "Endpoint not found.",
      "1010" => "Profile could not be found.",
      "1020" => "Update could not be found.",
      "1050" => "Client could not be found."
    },
    "405" => {
      "405"  => "Method not allowed."
    },
    "429" => {
      "429"  => "Too Many Requests."
    },
    "500" => {
      "1000" => "An unknown error occurred."
    },
    "400" => {
      "1003" => "Parameter not recognized.",
      "1004" => "Required parameter missing.",
      "1006" => "Parameter value not within bounds.",
      "1012" => "Profile did not save successfully.",
      "1016" => "Profile buffer could not be emptied.",
      "1022" => "Update did not save successfully.",
      "1025" => "Update was recently posted, can't post duplicate content.",
      "1026" => "Update must be in error status to requeue.",
      "1027" => "Update must be in buffer and not custom scheduled in order to move to top.",
      "1029" => "Event type not supported.",
      "1030" => "Media filetype not supported.",
      "1031" => "Media filesize out of acceptable range.",
      "1032" => "Unable to post image to LinkedIn group(s).",
      "1033" => "Comments can only be posted to Facebook at this time.",
      "1034" => "Cannot schedule updates in the past.",
      "1042" => "User did not save successfully."
    },
    "406" => {
      "1005" => "Unsupported response format."
    }
  }
end
