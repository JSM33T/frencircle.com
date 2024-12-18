﻿using API.Contracts.Services;
using API.Entities.Enums;
using Dapper;
using Microsoft.Data.SqlClient;
using System.Data;

namespace API.Infra
{
    public class DataService : IDataService
    {
        private readonly string _connectionString;

        public DataService(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task<IEnumerable<T>> QueryAsync<T>(string query, object parameters = null)
        {
            using IDbConnection db = new SqlConnection(_connectionString);
            return await db.QueryAsync<T>(query, parameters);
        }

        public async Task<T> QueryFirstOrDefaultAsync<T>(string query, object parameters = null)
        {
            using IDbConnection db = new SqlConnection(_connectionString);
            return await db.QueryFirstOrDefaultAsync<T>(query, parameters);
        }

        public async Task<int> ExecuteAsync(string query, object parameters = null)
        {
            using IDbConnection db = new SqlConnection(_connectionString);
            return await db.ExecuteAsync(query, parameters);
        }

        public async Task<DBResult> ExecuteStoredProcedureAsync(string storedProcedureName, object parameters = null)
        {
            using IDbConnection db = new SqlConnection(_connectionString);
            var dynamicParams = new DynamicParameters(parameters);
            dynamicParams.Add("DbResult", dbType: DbType.Int32, direction: ParameterDirection.Output);

            await db.ExecuteAsync(
                storedProcedureName,
                dynamicParams,
                commandType: CommandType.StoredProcedure
            );

            DBResult returnValue = dynamicParams.Get<DBResult>("DbResult");
            return returnValue;
        }
    }
}
