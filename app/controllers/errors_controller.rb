class ErrorsController < ApplicationController
  def not_found
    render :status => 404, :formats => [:html]
  end

  def server_error
    @description = self.descriptor[0]
    render :status => 500, :formats => [:html]
  end
  
  def descriptor
    ["boom", "kablooey", "kaboom", "crash", "grr-kk-pop", "kaput", "goodnight, sweetheart", "'Knock, knock,' Who's there? 'Error,' Error who? 'Sod this, I'm coming in'", "error-tastic", "profoundly wrong", "bad, like really bad", "south", "wrong, after starting so well", "'stop!', so we did", "'this doesn't add up', and sure enough they were right", "ka-blammo", "softly into the night", "dramatically wrong", "pear-shaped", "wrong. Again", "very well. Just kidding. It actually went badly wrong. Ha", "and got itself killed", "off the beaten path, as it were", "away and didn't come back", "astoundingly wrong", "spectacularly wrong", "right, but in the wrong way", "error-mad", "flamboyantly wrong", "sour"].sample(1)
  end
end