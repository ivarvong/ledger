#!/bin/bash
DATABASE_URL=postgres://`whoami`:@localhost:5432/ledger_test mix test.watch
