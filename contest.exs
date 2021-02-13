defmodule ContestStatus do
  destruct cancelled: false, finalized: false, past_deadline: false


def check(contest) do
  check(%ContestStatus{
    cancelled: contest.cancelled || false,
    finalized: contest.finalized || false,
    past_deadline: past_deadline(contest.picks_deadline)
      }
end

def check(%ContestStatus{ cancelled: true }),
  do: :contest_cancelled

def check(%ContestStatus{ finalized: true}),
  do: :contest_finalized

def check(%ContestStatus{ past_deadline: true}),
  do: :past_deadline

def check(%ContestStatus{}), do: :ok

def past_deadline_nil), do: false
def past_deadline(date), do: Ecto.DateTime.local > date

#6EQUJ5
#
#
