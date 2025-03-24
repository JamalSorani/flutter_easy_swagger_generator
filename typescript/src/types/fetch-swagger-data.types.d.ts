declare module "openapi-v3-typescript/types" {
  export type TMethodType = "get" | "post" | "put" | "delete" | "patch";

  export type TMediaType =
    | "multipart/form-data"
    | "application/json"
    | "text/plain"
    | "text/json"
    | "application/*+json";

  export type TNumberType = "integer" | "number";

  export type TPrimitiveType = TNumberType | "boolean" | "string";

  export type TDataType = TPrimitiveType | "array" | "object";

  export type IPrimitiveProperty = {
    type: TPrimitiveType;
  };

  export type IArrayProperty = {
    type: "array";
    items?: IProperty;
  };

  export type IRefProperty = {
    $ref:
      | `#/components/schemas/${string}`
      | `#/components/schemas/${string}.Enums.${string}`;
    type?: undefined;
  };

  export type IPropertyProperties = {
    [propertyName: string]: IProperty;
  };

  export type IObjectProperty = {
    type: "object";
    properties?: IPropertyProperties;
    additionalProperties?: IProperty | true;
  };

  export type IProperty = (
    | IPrimitiveProperty
    | IArrayProperty
    | IRefProperty
    | IObjectProperty
    | {
        $ref: "#/components/schemas/System.TimeSpan";
        type?: undefined;
      }
  ) & {
    nullable?: boolean;
    enum?: (number | string)[];
    oneOf?: IProperty[];
    anyOf?: IProperty[];
    allOf?: IProperty[];
    AnyValue?: {};
  };

  export type IParameter = {
    name: string;
    in: "query" | "header" | "path";
    schema?: IProperty;
    required?: boolean;
  };

  export type IResponse = {
    "200": {
      description?: string;
      content?: {
        [mediaType in TMediaType]?: {
          schema: IProperty;
        };
      };
    };
  };

  export type IRequestBody = IResponse["200"];

  export type IOpenApiJSON = {
    openapi: string;
    info: {
      title: string;
      description: string;
      version: string;
      contact?: {
        name: string;
      };
    };
    servers?: {
      url: string;
      description: string;
    }[];
    paths: {
      [route: string]: {
        [methodType in TMethodType]?: {
          summary?: string;
          description?: string;
          parameters?: IParameter[];
          requestBody?: IRequestBody;
          responses: IResponse;
        };
      };
    };
    components: {
      schemas: {
        [dtoOrEnumName: string]: IProperty;
      };
    };
  };

  // ----------------------------------------------------------------------

  export type TControllerInfo = {
    [controllerName: string]: TRouteInfo[];
  };

  export type TRouteInfo = {
    [route: string]: {
      hasResponse: boolean;
      hasBodyPayload: boolean;
      hasQueryParams: boolean;
      hasPathParams: boolean;
      hasPageParamInBody: string[];
      hasPageParamInQuery: string[];
      methodType: TMethodType;
      mediaType: TMediaType;
      parametersInPath: IParameter[];
    };
  };
}
