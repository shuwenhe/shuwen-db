#ifndef SQL_CMD_DML_INCLUDED
#define SQL_CMD_DML_INCLUDED

#include "sql/sql_cmd.h"

class Sql_cmd_dml : public Sql_cmd
{
private:
    /* data */
public:
    Sql_cmd_dml(/* args */);
    ~Sql_cmd_dml();
};

Sql_cmd_dml::Sql_cmd_dml(/* args */)
{
}

Sql_cmd_dml::~Sql_cmd_dml()
{
}
