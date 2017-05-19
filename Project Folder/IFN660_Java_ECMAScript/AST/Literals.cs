﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IFN660_Java_ECMAScript.AST
{
    public class IntegerLiteralExpression : Expression
    {
        private long value;
        public IntegerLiteralExpression(long value)
        {
            this.value = value;
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            return true;
        }
        public override void TypeCheck()
        {
            type = new NamedType("INT");
        }

        public override Type ObtainType()
        {
            return type;
        }

    }

    public class BooleanLiteralExpression : Expression
    {
        private readonly bool value;
        public BooleanLiteralExpression(bool value)
        {
            this.value = value;
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            return true;
        }
        public override void TypeCheck()
        {
            type = new NamedType("BOOLEAN");
        }

        public object GetValue()
        {
            return (object)value;
        }

        public string GetValueAsLiteral()
        {
            return value ? "true" : "false";
        }

        public long GetValueAsLong()
        {
            return value ? 1 : 0;
        }

        public override Type ObtainType()
        {
            return type;
        }
    }

    public class FloatingPointLiteralExpression : Expression
    {
        private readonly double value;
        public FloatingPointLiteralExpression(double value)
        {
            this.value = value;
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            return true;
        }
        public override void TypeCheck()
        {
            type = new NamedType("FLOAT");
        }
        public override Type ObtainType()
        {
            return type;
        }
    }

    public class CharacterLiteralExpression : Expression
    {
        private char value;
        public CharacterLiteralExpression(char value)
        {
            this.value = value;
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            return true;
        }
        public override void TypeCheck()
        {
            type = new NamedType("CHAR");
        }

        public override Type ObtainType()
        {
            return type;
        }
    }

    public class StringLiteralExpression : Expression
    {
        private string value;
        public StringLiteralExpression(string value)
        {
            this.value = value;
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            return true;
        }
        public override void TypeCheck()
        {
            type = new NamedType("String");
        }

        public override Type ObtainType()
        {
            return type;
        }
    }



}
