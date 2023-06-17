class Date
  FIVE_MINUTES = 5 * 60

  # Round up or down to the nearest 5 minute
  def self.nowish
    now = Time.local

    Time.unix(
      (
        (now.to_unix.to_f / FIVE_MINUTES).round * FIVE_MINUTES
      ).to_i
    )
  end
end
